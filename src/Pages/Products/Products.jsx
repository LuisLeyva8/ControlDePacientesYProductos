import NavBar from '../../Components/Navbar/Navbar';
import Cards from '../../Components/cards/Cards-Products/Cards';
import { PALETTE } from '../../constants/Colors';

const Products = () => {
    const colorContainerBackground = PALETTE.secondary; 

    return (
        <>
            <NavBar></NavBar>
            <div
                className="
                w-auto 
                pt-8 pb-10 
                my-12 mx-[10%] 
                rounded-md 
                shadow-xl 
                grid 
                grid-cols-2 
                sm:grid-cols-2 
                md:grid-cols-3 
                lg:grid-cols-4 
                gap-6 
                p-6 
                "
                style={{ backgroundColor: colorContainerBackground }}
            >
                <Cards></Cards>
                <Cards></Cards>
                <Cards></Cards>
                <Cards></Cards>
                <Cards></Cards>
                <Cards></Cards>
            </div>
        </>
    );
};

export default Products;
